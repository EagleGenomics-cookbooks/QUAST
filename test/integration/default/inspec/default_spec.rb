# Tests to check if the infrastructure we expect is available

# Check that the installation directory was created successfully
describe file(node['quast']['dir']) do
  it { should be_directory }
end

# QUAST automatically compiles all its sub-parts when needed (on the first use). Thus,
# there is no special installation command for QUAST. However, we recommend you to run:
describe command("python #{node['quast']['dir']}/quast.py --test") do # (if you plan to use quast.py)
  its('exit_status') { should eq 0 }
  its('stdout') { should match(//) }
end

describe command("python #{node['quast']['dir']}/quast.py --test-sv") do # (if you plan to use quast.py or metaquast.py with SV calling)
  its('exit_status') { should eq 0 }
  its('stdout') { should match(//) }
end

describe command("python #{node['quast']['dir']}/metaquast.py --test") do # (if you plan to use quast.py or metaquast.py with reference genomes)
  its('exit_status') { should eq 0 }
  its('stdout') { should match(//) }
end

describe command("python #{node['quast']['dir']}/metaquast.py --test-no-ref") do # (if you plan to use quast.py or metaquast.py without reference genomes)
  its('exit_status') { should eq 0 }
  its('stdout') { should match(//) }
end
