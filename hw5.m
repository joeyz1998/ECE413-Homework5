% Daniel Zuerbig
% ECE 413 Music and Engineering
% Homework Assignment 4, Effects

% This is the main run file

%% Sources
%
% ISO/IEC 11172 - Coding Of Moving Picture And Associated Audio For 
% Digital Storage Media At Up To About 1,5 Mbit/s - Part 3: Audio 
%
% Mu-Huo Cheng and Yu-Hsin Hsu (2003) Fast IMDCT and MDCT Algorithms - A Matrix Approach
% IEEE TRANSACTIONS ON SIGNAL PROCESSING, VOL. 51, NO. 1
%
% Seymour Shlien (1994) Guide to MPEG-1 Audio Standard
% IEEE TRANSACTIONS ON BROADCASTING, VOL. 40, NO.4
%
% Charles D. Murphy and K. Anandakumar (1997) Real-Time MPEG-1 Audio Coding and
% Decoding on a DSP Chip, IEEE Transactions on Consumer Electronics, Vol. 43, No. 1
%
%% Code

close all; clc; clear all;

[song, fs] = audioread('song2.wav');
% Sirius, Alan Parsons Project
song2 = audioread('song.wav');
% Never Going Back Again, Fleetwood Mac
song3 = audioread('spanish.wav');
% Spanish Harlem, Rebecca Pidgeon

songR = song(:,1)';
songL = song(:,2)';


YR = analyze(songR);
YL = analyze(songL);




YoutR = synthesize(YR);
YoutL = synthesize(YL);

Yout = [YoutR;YoutL];








