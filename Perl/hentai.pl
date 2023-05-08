use LWP::UserAgent;
use File::Path qw(make_path);
use JSON qw(decode_json);

my @URLS = (
    "https://nekobot.xyz/api/image?type=hentai",
    "https://api.waifu.pics/nsfw/waifu",
    "https://api.waifu.pics/nsfw/neko",
    "https://api.waifu.pics/nsfw/blowjob"
);

if (! -d "./Hentai") {
    make_path("./Hentai");
}

my $i = 0;

sub main {
    my ($i) = @_;
    while (1) {
        foreach my $url (@URLS) {
            my $ua = LWP::UserAgent->new(agent => "Perl script");
            my $res = $ua->get($url);
            print $res->content;
            eval {
                my $json = decode_json($res->content);
                my $link;
                if ($url =~ /waifu/) {
                    $link = $json->{'url'};
                } else {
                    $link = $json->{'message'};
                }
                my @s = split('/', $link);
                my $Name = pop(@s);
                my $ua2 = LWP::UserAgent->new(agent => "Perl script2");
                my $rep = $ua2->mirror($link, "./Hentai/$Name");
                $i++;
                print "Downloaded $i hentai\n";
            };
            if ($@) {
                print "$@\n";
            }
        }
    }
}

main($i);