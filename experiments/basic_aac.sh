#!/usr/bin/env bash
BASEDIR=$(dirname "$( cd "$( dirname "$0" )" && pwd )")
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 [train|resume|test]"
    exit 1
fi

COMMAND="$1"
MODEL=aac
CHECK_POINT=$BASEDIR/checkpoints/1room_back_random_aac_cp.pth
CONFIG=$BASEDIR/environments/my_way_home.cfg
INSTANCE=basic
#WAD=$BASEDIR/environments/rooms_random/1roomback_random.wad

if [ $COMMAND == 'train' ]
then
    python3 $BASEDIR/src/main.py \
    --mode train \
    --episode_size 20 \
    --batch_size 10 \
    --episode_discount 0.95 \
    --model $MODEL \
    --doom_instance $INSTANCE \
    --vizdoom_config $CONFIG \
    --skiprate 4 \
    --frame_num 1 \
    --checkpoint_file $CHECK_POINT \
    --checkpoint_rate 100 \
    --episode_num 700
elif [ $COMMAND == 'resume' ]
then
    python3 $BASEDIR/src/main.py \
    --mode train \
    --episode_size 20 \
    --batch_size 20 \
    --episode_discount 0.95 \
    --model $MODEL \
    --load $CHECK_POINT \
    --doom_instance $INSTANCE \
    --vizdoom_config $CONFIG \
    --skiprate 4 \
    --frame_num 1 \
    --checkpoint_file $CHECK_POINT \
    --checkpoint_rate 100 \
    --episode_num 500
elif [ $COMMAND == 'test' ]
then
    python3 $BASEDIR/src/main.py \
    --mode test \
    --model $MODEL \
    --load $CHECK_POINT \
    --doom_instance $INSTANCE \
    --vizdoom_config $CONFIG \
    --skiprate 1 \
    --frame_num 1
else
    echo "'$COMMAND' is unknown command."
fi
