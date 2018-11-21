#! /usr/bin/perl

#$cmd = "make poll";
$cmd = "make put";

# Cheesy ls wrapper. Dir MUST end in /.
sub dirls($)
{
    my $dir = shift @_;
    my @r = `ls $dir`;
    foreach (@r)
    {
        chomp $_;
        $_ = $dir . $_;
    }
    return @r;
}

@files = ( 'Makefile' );
push @files, dirls('lang');
push @files, 'LibCraftText.lua';
push @files, 'LibCraftText_Internal.lua';
push @files, 'LibCraftText_Discover.lua';
push @files, 'LibCraftText_Example1.lua';
push @files, 'LibCraftText_Example2.lua';
push @files, 'LibCraftText_Example3.lua';
print join("\n", @files) . "\n";

@prev_mtime = ();

$sleep_sec      =  2;
$dot_period_sec = 10;
$dot_sleep_sec  =  0;

sub mod_time()
{
    @mtime = ();
    foreach $file (@files)
    {
# print("FILE: $file .\n");
        @x = lstat $file;
        push @mtime, $x[9];
    }
    return @mtime;
}

for ( ; ; )
{
    @mtime = mod_time();

    if (join(" ", @mtime) ne join(" ", @prev_mtime))
    {
        clear_screen();
        print `$cmd 2>&1`;

        print STDERR "\n... waiting for changes ";
    }

    @prev_mtime = mod_time();

    sleep $sleep_sec;

    $dot_sleep_sec += $sleep_sec;
    if ($dot_period_sec <= ++$dot_sleep_sec)
    {
        $dot_sleep_sec = 0;
        print STDERR ".";
    }
}

sub clear_screen()
{
    my $clear      = "\e[2J";
    my $cursorhome = "\e[H";

    print "$clear$cursorhome";
}
