# Virtual Playing Orchestra Template

## What is this?
This is an Ardour project template for composing orchestral music, using only Linux-native plugins.

## Requirements
This template has been tested with:
* Ubuntu 16.04 LTS
* 8GB memory
* Quad-core i5 3GHz CPU

The system monitor reports Ardour using about 2GB of memory and only moderate CPU usage with a rather full orchestral score, so it will probably work with 4GB of memory and a much less powerful CPU.

It will probably easily work with audio-centric Debian-based flavors of Linux, including AVLinux, KX Studio, and Ubuntu Studio.

### Assumptions

* A working Linux system, properly configured for audio production
* Knowledge of how to use Ardour
* Understanding of Linux terminal and filesystem

### Software 

This project template uses the following software:

* [Ardour 5.5+](http://ardour.org/)
* [LinuxSampler](https://linuxsampler.org/)
* [x42 Midi Channel Map](http://x42-plugins.com/x42/x42-midifilter)
* [Invada Early Reflection Reverb](https://launchpad.net/invada-studio)
* [Invada Low Pass Filter](https://launchpad.net/invada-studio)
* [TAP Reverberator](http://tap-plugins.sourceforge.net/ladspa/reverb.html)
* [Virtual Playing Orchestra](http://virtualplaying.com/)
* [Maestro Concert Grand Piano](http://sonimusicae.free.fr/matshelgesson-maestro-en.html)

To install the plugins and virtual instruments:

The plugins can all be obtained from the KX Studio repos. Follow [these directions](http://kxstudio.linuxaudio.org/Repositories) to enable the repos if you do not already have access to them.

`$ sudo apt install linuxsampler-vst x42-plugins invada-studio-plugins-lv2 tap-lv2 unrar-free`

Download [Virtual Playing Orchestra](http://virtualplaying.com/) and [Maestro Concert Grand Piano](http://sonimusicae.free.fr/matshelgesson-maestro-en.html), then extract both to `/opt`. Assuming they are both in your `~/Downloads`:

```
cd ~/Downloads
sudo unzip Virtual-Playing-Orchestra-v1.0.zip -d /opt
sudo mkdir /opt/maestro-concert-grand
sudo unrar x Maestro-Concert-Grandv2.rar /opt/maestro-concert-grand/
```

## Using the template

The template is all contained in one file. Download `virtual-playing-orchestra-template.ardour` from this project and open it in Ardour.

The project shows a minimal set of midi tracks and a small number of busses. There is one midi track for each section of the orchestra. Almost every instrument section has additional hidden tracks for solos and articulations. You can view any track by going to the mixer and putting a checkmark under "Show" in the left sidebar.

Plural and singular names distinguish between ensemble and solo tracks. Additional articulations are indicated as a suffix on the track name. For example, "1st Violin Pizz" is a solo first violin playing pizzicato, "2nd Violins Trem" is the entire second violins section playing tremolo.

To play a tuba part (for example), route your midi keyboard input to "Tuba in", play bass keys on your midi keyboard, and you should hear the tuba. To record, arm the Tuba track, click the record button and then the play button, and then play the part on your midi keyboard.

### Seating

Each section and solo part is given distinct stage presence with a more or less traditional seating arrangement:

![Seating Chart](seating.png)

Some liberties were taken with the layout of the percussion, and the piano is centered instead of being on the traditional far left with the harp.

## More technical details

Each midi track routes into one of four LinuxSampler plugin instances, which then route to an audio bus per section/solo.

Almost all audio busses are not shown by default, to hide most of the complexity. If you want to add plugins or otherwise adjust the audio output of a given section, each instrument section has a corresponding hidden audio bus, with the suffix "Bus" to distinguish it from the midi track.

### Stage Presence

Panning and stereo width are set on the hidden audio busses corresponding to each section. All of these busses are routed into four visible busses called "Row 1", "Row 2", "Row 3", and "Row 4". Each row is set up for different stage depth. Each has volume-adjusted routing to both the master bus and the concert hall reverb bus. Rows 1, 2, and 3 have delays before the reverb.

For additional frontal stage presence, instruments in rows 1 and 2 each have a subtle amount of audio routed to individualized early reflection reverb busses.

### LinuxSampler Configuration

There are four LinuxSampler Instances: Woodwinds, Brass/Percussion, Strings 1, and Strings 2.

(The sections in parenthesis that say "Reserved for" are wishful thinking)

<table>
    <thead>
        <th colspan="3">LinuxSampler Instance #1: Woodwinds</th>
    </thead>
    <tr>
        <th>Midi channel</th>
        <th>Audio channels</th>
        <th>Instrument</th>
    </tr>
    <tr>
        <td>1</td>
        <td>1, 2</td>
        <td>Piccolo</td>
    </tr>
    <tr>
        <td>2</td>
        <td>3, 4</td>
        <td>Flute</td>
    </tr>
    <tr>
        <td>3</td>
        <td>5, 6</td>
        <td>Flutes</td>
    </tr>
    <tr>
        <td>4</td>
        <td>7, 8</td>
        <td>Unused (Reserved for Pan Flute)</td>
    </tr>
    <tr>
        <td>5</td>
        <td>9, 10</td>
        <td>Unused (Reserved for Alto Flute)</td>
    </tr>
    <tr>
        <td>6</td>
        <td>11, 12</td>
        <td>Unused</td>
    </tr>
    <tr>
        <td>7</td>
        <td>13, 14</td>
        <td>Oboe</td>
    </tr>
    <tr>
        <td>8</td>
        <td>15, 16</td>
        <td>Oboes</td>
    </tr>
    <tr>
        <td>9</td>
        <td>17, 18</td>
        <td>Cor Anglais (English Horn)</td>
    </tr>
    <tr>
        <td>10</td>
        <td>19, 20</td>
        <td>Unused</td>
    </tr>
    <tr>
        <td>11</td>
        <td>21, 22</td>
        <td>Clarinet</td>
    </tr>
    <tr>
        <td>12</td>
        <td>23, 24</td>
        <td>Clarinets</td>
    </tr>
    <tr>
        <td>13</td>
        <td>25, 26</td>
        <td>Unused (Reserved for Bass Clarinet)</td>
    </tr>
    <tr>
        <td>14</td>
        <td>27, 28</td>
        <td>Bassoon</td>
    </tr>
    <tr>
        <td>15</td>
        <td>29, 30</td>
        <td>Bassoons</td>
    </tr>
    <tr>
        <td>16</td>
        <td>31, 32</td>
        <td>Unused (Reserved for Contrabassoon)</td>
    </tr>
        <thead>
        <th colspan="3">LinuxSampler Instance #2: Brass/Percussion</th>
    </thead>
    <tr>
        <th>Midi channel</th>
        <th>Audio channels</th>
        <th>Instrument</th>
    </tr>
    <tr>
        <td>1</td>
        <td>1, 2</td>
        <td>Horn</td>
    </tr>
    <tr>
        <td>2</td>
        <td>3, 4</td>
        <td>Horns</td>
    </tr>
    <tr>
        <td>3</td>
        <td>5, 6</td>
        <td>Trumpet</td>
    </tr>
    <tr>
        <td>4</td>
        <td>7, 8</td>
        <td>Trumpets</td>
    </tr>
    <tr>
        <td>5</td>
        <td>9, 10</td>
        <td>Trombone</td>
    </tr>
    <tr>
        <td>6</td>
        <td>11, 12</td>
        <td>Trombones</td>
    </tr>
    <tr>
        <td>7</td>
        <td>13, 14</td>
        <td>Tuba</td>
    </tr>
    <tr>
        <td>8</td>
        <td>15, 16</td>
        <td>Unused (Reserved for Bass Trombone or other bass brass)</td>
    </tr>
    <tr>
        <td>9</td>
        <td>17, 18</td>
        <td>Bass Drum, Snares, Cymbals</td>
    </tr>
    <tr>
        <td>10</td>
        <td>19, 20</td>
        <td>Misc. Percussion (Tambourine, Conga, Bell trees, etc) </td>
    </tr>
    <tr>
        <td>11</td>
        <td>21, 22</td>
        <td>Glockenspiel</td>
    </tr>
    <tr>
        <td>12</td>
        <td>23, 24</td>
        <td>Xylophone</td>
    </tr>
    <tr>
        <td>13</td>
        <td>25, 26</td>
        <td>Unused (Reserved for Celeste or Marimba)</td>
    </tr>
    <tr>
        <td>14</td>
        <td>27, 28</td>
        <td>Tubular Bells</td>
    </tr>
    <tr>
        <td>15</td>
        <td>29, 30</td>
        <td>Timpani Hit</td>
    </tr>
    <tr>
        <td>16</td>
        <td>31, 32</td>
        <td>Timpani Roll</td>
    </tr>
        <thead>
        <th colspan="3">LinuxSampler Instance #3: Strings 1</th>
    </thead>
    <tr>
        <th>Midi channel</th>
        <th>Audio channels</th>
        <th>Instrument</th>
    </tr>
    <tr>
        <td>1</td>
        <td>1, 2</td>
        <td>Grand Piano</td>
    </tr>
    <tr>
        <td>2</td>
        <td>3, 4</td>
        <td>Unused (Reserved for Harpsichord)</td>
    </tr>
    <tr>
        <td>3</td>
        <td>5, 6</td>
        <td>Harp (Sustain)</td>
    </tr>
    <tr>
        <td>4</td>
        <td>7, 8</td>
        <td>Harp (Dampened)</td>
    </tr>
    <tr>
        <td>5</td>
        <td>9, 10</td>
        <td>Unused</td>
    </tr>
    <tr>
        <td>6</td>
        <td>11, 12</td>
        <td>1st Violin</td>
    </tr>
    <tr>
        <td>7</td>
        <td>13, 14</td>
        <td>1st Violin Pizzicato</td>
    </tr>
    <tr>
        <td>8</td>
        <td>15, 16</td>
        <td>1st Violins</td>
    </tr>
    <tr>
        <td>9</td>
        <td>17, 18</td>
        <td>1st Violins Pizzicato</td>
    </tr>
    <tr>
        <td>10</td>
        <td>19, 20</td>
        <td>1st Violins Tremolo</td>
    </tr>
    <tr>
        <td>11</td>
        <td>21, 22</td>
        <td>2nd Violin</td>
    </tr>
    <tr>
        <td>12</td>
        <td>23, 24</td>
        <td>2nd Violin Pizzicato</td>
    </tr>
    <tr>
        <td>13</td>
        <td>25, 26</td>
        <td>2nd Violins</td>
    </tr>
    <tr>
        <td>14</td>
        <td>27, 28</td>
        <td>2nd Violins Pizzicato</td>
    </tr>
    <tr>
        <td>15</td>
        <td>29, 30</td>
        <td>2nd Violins Tremolo</td>
    </tr>
    <tr>
        <td>16</td>
        <td>31, 32</td>
        <td>Unused</td>
    </tr>
        <thead>
        <th colspan="3">LinuxSampler Instance #4: String 2</th>
    </thead>
    <tr>
        <th>Midi channel</th>
        <th>Audio channels</th>
        <th>Instrument</th>
    </tr>
    <tr>
        <td>1</td>
        <td>1, 2</td>
        <td>Viola</td>
    </tr>
    <tr>
        <td>2</td>
        <td>3, 4</td>
        <td>Viola Pizzicato</td>
    </tr>
    <tr>
        <td>3</td>
        <td>5, 6</td>
        <td>Violas</td>
    </tr>
    <tr>
        <td>4</td>
        <td>7, 8</td>
        <td>Violas Pizzicato</td>
    </tr>
    <tr>
        <td>5</td>
        <td>9, 10</td>
        <td>Violas Tremolo</td>
    </tr>
    <tr>
        <td>6</td>
        <td>11, 12</td>
        <td>Cello</td>
    </tr>
    <tr>
        <td>7</td>
        <td>13, 14</td>
        <td>Cello Pizzicato</td>
    </tr>
    <tr>
        <td>8</td>
        <td>15, 16</td>
        <td>Cellos</td>
    </tr>
    <tr>
        <td>9</td>
        <td>17, 18</td>
        <td>Cellos Pizzicato</td>
    </tr>
    <tr>
        <td>10</td>
        <td>19, 20</td>
        <td>Cellos Tremolo</td>
    </tr>
    <tr>
        <td>11</td>
        <td>21, 22</td>
        <td>Contrabass</td>
    </tr>
    <tr>
        <td>12</td>
        <td>23, 24</td>
        <td>Contrabass Pizzicato</td>
    </tr>
    <tr>
        <td>13</td>
        <td>25, 26</td>
        <td>Contrabasses</td>
    </tr>
    <tr>
        <td>14</td>
        <td>27, 28</td>
        <td>Contrabasses Pizzicato</td>
    </tr>
    <tr>
        <td>15</td>
        <td>29, 30</td>
        <td>Contrabasses Tremolo</td>
    </tr>
    <tr>
        <td>16</td>
        <td>31, 32</td>
        <td>Unused</td>
    </tr>
</table>
