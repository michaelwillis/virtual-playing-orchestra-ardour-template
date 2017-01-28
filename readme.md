# Virtual Playing Orchestra Template

## What is this?
This is an Ardour project template for composing orchestral music, using only Linux-native plugins.

## Requirements
This template has been tested on a rather commodity system running Ubuntu 16.04 LTS with 8GB of memory and a quad-core i5 3GHz CPU. The system monitor reports Ardour using about 2GB of memory and only moderate CPU usage with a rather full orchestral score, so it will probably work with 4GB of memory and a much less powerful CPU.

It will also probably work with other similar debian-based flavors of Linux that have been properly configured for audio production, including AVLinux, KX Studio, and Ubuntu Studio.

Setup and usage of the template requires a working knowledge of Ardour and at least a cursory knowledge of the terminal and filesystem on Linux.

### Software 

This project template uses the following software:

* [Ardour 5.5+](http://ardour.org/)
* [LinuxSampler](https://linuxsampler.org/)
* [x42 Midi Channel Map](http://x42-plugins.com)
* [Invada Early Reflection Reverb and Low Pass Filter](https://launchpad.net/invada-studio)
* [TAP Reverberator](http://tap-plugins.sourceforge.net/)
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

The template is all contained in one file. Download `virtual-playing-orchestra-template` from this project and open it in Ardour.

The project shows a minimal set of midi tracks and a small number of busses. There is one midi track for each section of the orchestra. Almost every instrument section has additional hidden tracks for solos and articulations. You can view any track by going to the mixer and putting a checkmark under "Show" in the left sidebar.

Plural and singular names distinguish between ensemble and solo tracks. Additional articulations are indicated as a suffix on the track name. For example, "1st Violin Pizz" is a solo first violin playing pizzicato, "2nd Violins Trem" is the entire second violins section playing tremolo.

There is a midi bus called "Midi In" at the top for recording convenience. Using the editor mixer sidebar on the left, you can route this channel to a given track for playing and recording. You can see at the bottom that it defaults to Piano. To play a tuba part (for example), change this to "Tuba in", play bass keys on your midi keyboard, and you should hear the tuba. To record, arm the Tuba track, click the record button and then the play button, and then play the part on your midi keyboard.

### Seating

Each section and solo part is given distinct stage presence with a more or less traditional seating arrangement:

![Seating Chart](seating.png)

### More technical details

Almost all audio busses are not shown by default, to hide most of the complexity. If you want to add plugins or otherwise adjust the audio output of a given section, each instrument section has a corresponding hidden audio bus, with the suffix "Bus" to distinguish it from the midi track.

Panning and stereo width are set on the hidden audio busses corresponding to each section. All of these busses are routed into four visible busses called "Row 1", "Row 2", "Row 3", and "Row 4".
