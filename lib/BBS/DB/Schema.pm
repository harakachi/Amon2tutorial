package BBS::DB::Schema;
use strict;
use warnings;
use utf8;

use Teng::Schema::Declare;

base_row_class 'BBS::DB::Row';

table {
    name 'memos';
    pk 'id';
    columns qw(id text);
};

1;
