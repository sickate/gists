for file in *.mp4
do
    NEWFILE=$(echo "$file" |sed -E 's/纸牌屋.House.Of.Cards.2013.|.Chi_Eng.HR-BluRay.AC3.1024X512.x264-YYeTs人人影视//g')
    mv -v $file $NEWFILE
done

# encoding change
# following line cost me ALL MY TXTS!
# FIXME
for file in *.txt
do
    iconv --verbose -f gb-18030 -t utf-8 -o $file > $file;
done
