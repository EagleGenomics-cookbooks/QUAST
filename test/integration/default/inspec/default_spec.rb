
# Check that the installation directory was created successfully
describe file('/usr/local/quast-4.2') do
  it { should be_directory }
end

# QUAST automatically compiles all its sub-parts when needed (on the first use). Thus,
# there is no special installation command for QUAST. However, we recommend you to run:
describe command('python /usr/local/quast-4.2/quast.py --test') do # (if you plan to use quast.py)
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/Thank you for using QUAST!/) }
end

describe command('python /usr/local/quast-4.2/quast.py --test-sv') do # (if you plan to use quast.py or metaquast.py with SV calling)
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/Thank you for using QUAST!/) }
end

describe command('python /usr/local/quast-4.2/metaquast.py --test') do # (if you plan to use quast.py or metaquast.py with reference genomes)
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/Thank you for using QUAST!/) }
end

describe command('python /usr/local/quast-4.2/metaquast.py --test-no-ref') do # (if you plan to use quast.py or metaquast.py without reference genomes)
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/Thank you for using QUAST!/) }
end

# run over supplied test data
describe command('/usr/local/quast-4.2/quast.py /usr/local/quast-4.2/test_data/contigs_1.fasta /usr/local/quast-4.2/test_data/contigs_2.fasta -R /usr/local/quast-4.2/test_data/reference.fasta.gz -G /usr/local/quast-4.2/test_data/genes.gff') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/Thank you for using QUAST!/) }
end

describe file('/usr/local/quast-4.2/quast_results/latest/report.txt') do
  it { should exist }
  its('content') { should match 'All statistics are based on contigs of size >= 500 bp, unless otherwise noted' }
  its('content') { should match 'Reference length' }
  its('content') { should match '10000' }
  its('content') { should match 'NGA50' }
  its('content') { should match '1610' }
end
