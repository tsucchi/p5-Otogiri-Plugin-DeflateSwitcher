requires 'Otogiri', '0.06';
requires 'Otogiri::Plugin', '0.02';
requires 'parent';
requires 'perl', '5.008005';

on configure => sub {
    requires 'CPAN::Meta';
    requires 'CPAN::Meta::Prereqs';
    requires 'Module::Build';
};

on 'test' => sub {
    requires 'Test::More', '0.98';
    requires 'DBD::SQLite';
};
