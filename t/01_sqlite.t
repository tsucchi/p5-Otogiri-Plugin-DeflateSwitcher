use strict;
use warnings;
use Test::More;
use Otogiri;
use Otogiri::Plugin;

my $deflate_called = 0;

subtest 'can', sub {
    my ($db) = prepare();
    ok( $db->can('enable_deflate') );
    ok( $db->can('disable_deflate') );
};

subtest 'default (enable)', sub {
    my $db = prepare();
    $db->fast_insert('person', {
        name => 'Sherlock Shellingford',
        age  => 15,
    });

    is( $deflate_called, 1);
};


subtest 'enable_deflate', sub {
    my ($db, $id) = prepare();

    $db->enable_deflate;
    $db->fast_insert('person', {
        name => 'Sherlock Shellingford',
        age  => 15,
    });
    is( $deflate_called, 1);
};

subtest 'disable_deflate', sub {
    my ($db, $id) = prepare();

    $db->disable_deflate;
    $db->fast_insert('person', {
        name => 'Sherlock Shellingford',
        age  => 15,
    });
    is( $deflate_called, 0);
};

subtest 'enable_deflate with guard previous disabled', sub {
    my ($db, $id) = prepare();

    $db->disable_deflate;
    {
        my $guard = $db->enable_deflate;
        $db->fast_insert('person', {
            name => 'Sherlock Shellingford',
            age  => 15,
        });
        is( $deflate_called, 1);
    }
    my $row = $db->single('person', { id => $id });
    is( $deflate_called, 1); #deflate is now disabled
};

subtest 'enable_deflate with guard previous enabled', sub {
    my ($db, $id) = prepare();

    $db->enable_deflate;
    {
        my $guard = $db->enable_deflate;
        $db->fast_insert('person', {
            name => 'Sherlock Shellingford',
            age  => 15,
        });
        is( $deflate_called, 1);
    }
    my $row = $db->single('person', { id => $id });
    is( $deflate_called, 2);
};

subtest 'disable_deflate with guard previous disabled', sub {
    my ($db, $id) = prepare();

    $db->disable_deflate;
    {
        my $guard = $db->disable_deflate;
        $db->fast_insert('person', {
            name => 'Sherlock Shellingford',
            age  => 15,
        });
        is( $deflate_called, 0);
    }
    my $row = $db->single('person', { id => $id });
    is( $deflate_called, 0);
};

subtest 'disable_deflate with guard previous enabled', sub {
    my ($db, $id) = prepare();

    $db->enable_deflate;
    {
        my $guard = $db->disable_deflate;
        $db->fast_insert('person', {
            name => 'Sherlock Shellingford',
            age  => 15,
        });
        is( $deflate_called, 0);
    }
    my $row = $db->single('person', { id => $id });
    is( $deflate_called, 1);
};


done_testing;

sub prepare {
    $deflate_called = 0;
    my $db = Otogiri->new( 
        connect_info => ["dbi:SQLite:dbname=:memory:", '', '', { RaiseError => 1, PrintError => 0 }],
        deflate      => sub {
            my ($data, $table_name) = @_;
            $deflate_called++;
            return $data;
        },
    );
    $db->load_plugin('DeflateSwitcher');
    my @sql_statements = split /\n\n/, <<EOSQL;
CREATE TABLE person (
  id   INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT    NOT NULL,
  age  INTEGER NOT NULL DEFAULT 20
);
EOSQL
    $db->do($_) for @sql_statements;
    return $db;
}
