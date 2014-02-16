package BBS::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;

any '/' => sub {
    my ($c) = @_;
    return $c->render('index.tx');
};

post '/account/logout' => sub {
    my ($c) = @_;
    $c->session->expire();
    return $c->redirect('/');
};

get '/memo' => sub {
    my ($c) = @_;
    my $latest_text = $c->db->latest_text;
    $latest_text //= "no comment";
    return $c->render('memo.tx', { latest_text => $latest_text } );
    #return $c->render('memo.tx');
};

post '/memo/insert' => sub {
    my ($c) = @_;
    my $text = $c->req->param('text');
    $c->db->insert_memo($text);
    return $c->redirect('/memo');
};

=pod
any '/' => sub {
    my ($c) = @_;
    my $counter = $c->session->get('counter') || 0;
    $counter++;
    $c->session->set('counter' => $counter);
    return $c->render('index.tx', {
        counter => $counter,
    });
};

post '/reset_counter' => sub {
    my $c = shift;
    $c->session->remove('counter');
    return $c->redirect('/');
};

post '/account/logout' => sub {
    my ($c) = @_;
    $c->session->expire();
    return $c->redirect('/');
};
=cut

1;
