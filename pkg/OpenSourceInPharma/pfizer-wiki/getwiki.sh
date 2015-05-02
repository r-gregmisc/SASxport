#!/bin/sh
wget -N -r -nd ftp://rstatserver.pfizer.com:8021/CommercialRSupport/
svn add *
svn commit -m "Automatic update of wiki information"
