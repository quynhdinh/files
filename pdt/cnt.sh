while true
do
    echo $(date)
     echo 'select count(*) from profile' | docker exec -i bench-postgres psql -U postgres
sleep 10 
done

