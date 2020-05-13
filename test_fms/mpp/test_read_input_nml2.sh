#!/bin/sh

#***********************************************************************
#                   GNU Lesser General Public License
#
# This file is part of the GFDL Flexible Modeling System (FMS).
#
# FMS is free software: you can redistribute it and/or modify it under
# the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or (at
# your option) any later version.
#
# FMS is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
# for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with FMS.  If not, see <http://www.gnu.org/licenses/>.
#***********************************************************************

# This is part of the GFDL FMS package. This is a shell script to
# execute tests in the test_fms/mpp directory.

# Colin Gladue 04/27/2020

touch test_numb_base.nml
echo "&test_read_input_nml_nml" > test_numb_base.nml
echo "test_numb = 0" >> test_numb_base.nml
echo "/" >> test_numb_base.nml

# Test 1
sed "s/test_numb = [0-9]/test_numb = 1/" test_numb_base.nml > test_numb.nml
cp input_base.nml input.nml
./test_read_input_nml.sh
if [ $? = 0 ]; then
  echo "Test 1 has passed"
else
  echo "ERROR: Test 1 was unsuccessful."
  exit 11
fi

# Test 2
sed "s/test_numb = [0-9]/test_numb = 2/" test_numb_base.nml > test_numb.nml
cp input_base.nml input_alternative.nml
./test_read_input_nml.sh
if [ $? = 0 ]; then
  echo "Test 2 has passed"
else
  echo "ERROR: Test 2 was unsuccessful."
  exit 12
fi

# Test 3
sed "s/test_numb = [0-9]/test_numb = 3/" test_numb_base.nml > test_numb.nml
cp input_base.nml input.nml
./test_read_input_nml.sh
if [ $? = 1 ]; then
  echo "Test 3 has passed"
else
  echo "ERROR: Test 3 did not hit the error it was expected to"
  exit 13
fi

# Test 4
sed "s/test_numb = [0-9]/test_numb = 4/" test_numb_base.nml > test_numb.nml
rm input.nml
touch input.nml # Achieve a blank namelist to be read
./test_read_input_nml.sh
if [ $? = 0 ]; then
  echo "Test 4 has passed"
else
  echo "ERROR: Test 4 was unsuccessful."
  exit 14
fi

cp input_base.nml input.nml