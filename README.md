Testbat: a shell toolkit for BAT(Basic Audio Tester) utils.

BAT is a small util for audio driver automated testing.
The latest features and wiki are on www://github.com/01org/bat.
The repo is also available on git://git.alsa-project.org/alsa-utils.git.

featuretest.sh
basic test for BAT features, like playback, capture, frequency detecting,
RIFF WAV file generating, etc.

soundpathtest.sh
BAT frequency detecting stress test on DP/HDMI/headphone/line-out to
microphone/line-in loopback.

quicktest.sh
BAT frequency detecting test. It is optimized against one frequency so
much faster than regular frequency detecting.
