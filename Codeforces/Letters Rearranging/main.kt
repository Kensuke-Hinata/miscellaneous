package redocpot

fun main(args : Array<String>) {
    val T = readLine()!!.toInt()
    for (i in 1 .. T) {
        val s = readLine()!!
        val a = IntArray(26)
        for (c in s) {
            ++ a[c - 'a']
        }
        var fc : Char = ' '
        var sc : Char = ' '
        for (j in 0 .. 25) {
            if (a[j] > 0) {
                -- a[j]
                if (fc.equals(' ')) {
                    fc = 'a' + j
                } else {
                    sc = 'a' + j
                    break
                }
            }
        }
        if (sc.equals(' ')) {
            println(-1)
        } else {
            print(fc)
            for (j in 0 .. 25) {
                for (k in 1 .. a[j]) {
                    print('a' + j)
                }
            }
            println(sc)
        }
    }
}
