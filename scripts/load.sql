echo "turn off log";
log_enable(2,1);
# for some reason $I works but anything after first -i arg cant be referenced.
# http://docs.openlinksw.com/virtuoso/isql.html
echo DB.DBA.TTLP_MT (file_to_string_output($ARGV[$I]), '', $ARGV[7]);
DB.DBA.TTLP_MT (file_to_string_output('$ARGV[$I]'), '', '$ARGV[7]');
echo checkpoint;
checkpoint;
echo commit WORK;
commit WORK;
