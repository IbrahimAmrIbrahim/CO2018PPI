@echo off
REM ****************************************************************************
REM Vivado (TM) v2018.2 (64-bit)
REM
REM Filename    : elaborate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for elaborating the compiled design
REM
<<<<<<< HEAD
REM Generated by Vivado on Thu Dec 13 21:32:08 +0200 2018
=======
REM Generated by Vivado on Thu Dec 13 20:56:43 +0200 2018
>>>>>>> 85ae3f984b74babb4ff763c1b6a72a57b123bcf9
REM SW Build 2258646 on Thu Jun 14 20:03:12 MDT 2018
REM
REM Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
REM
REM usage: elaborate.bat
REM
REM ****************************************************************************
call xelab  -wto 66223dc40a1b4371b9bedc03532d6795 --incr --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot tb_RobinRound_behav xil_defaultlib.tb_RobinRound xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
