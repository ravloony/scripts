
for i in *.inc; 
do 
	cat $i |  sed 's/search/replace/g' > $i.new; 
	mv $i.new $i;
done
