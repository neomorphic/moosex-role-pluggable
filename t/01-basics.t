#! perl

use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/lib";
require MyTest;

use Test::More;

my $app = MyApp->new({
  plugins => [
    'Foo' ,
    'Baz' ,
    '+MyApp::OtherPlugin::Bar' ,
  ] ,
});

isa_ok( $app , 'MyApp' );

my $plugins = $app->plugin_hash;

ok( $plugins->{'MyApp::OtherPlugin::Bar'}->can('bar') , 'Bar does bar' );
ok( $plugins->{Baz}->can('baz')                       , 'Baz does baz' );
ok( $plugins->{Foo}->can('foo')                       , 'Foo does foo' );

ok( ! $plugins->{'MyApp::OtherPlugin::Bar'}->can('common') , 'Bar does not do common' );

ok( $plugins->{Baz}->can('common') , 'Baz does common' );
ok( $plugins->{Foo}->can('common') , 'Foo does common' );

done_testing;