# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    asmcomp.sh                                         :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/19 09:24:58 by rlucas        #+#    #+#                  #
#    Updated: 2020/02/19 09:28:45 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

#!/bin/bash
if [ -z "$1" ];
then
	exit 1
fi
nasm -fmacho64 $1.s
ld $1.o -o $1 -macosx_version_min 10.13 -lSystem -no_pie
