BEGIN{printf("s;<<date>>;%s;\n", udate);}
NR == 1 {   
    if(NF == 3)
    { iname=$2 FS $3; 
    printf("s/<<item_name>>/%s/\n", iname);
    }
    else
    {
    printf("s/<<item_name>>/%s/\n", $2);
    }
    printf("s/<<simple_name>>/%s/\n", $1);
}
NR == 2 {
    doiprint=($1/$2)*100;
    if(doiprint<10)
    {
    printf("s/<<current_quantity>>/%s/\n", $1);
    printf("s/<<max_quantity>>/%s/\n", $2);
    }
    else
    { print("DO NOTHING"); 
      exit 1}
}
NR == 3 {
    printf("s/<<body>>/%s/", $0);
}
