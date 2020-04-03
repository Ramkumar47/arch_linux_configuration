($6 == "/"){
    rootP = $5
    rootN = $3
    rootD = $4
}
($6 == "/boot"){
    bootP = $5
    bootN = $3
    bootD = $4
}
($6 == "/home"){
    homeP = $5
    homeN = $3
    homeD = $4
}
END{
    print "     \t usage \t\t percentage"
    print "     \t ----- \t\t ----------"
    print "boot \t "bootN"/"bootD" \t "bootP
    print "root \t "rootN"/"rootD" \t "rootP
    print "home \t "homeN"/"homeD" \t "homeP
}
