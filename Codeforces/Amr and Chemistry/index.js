function calcBits(n) {
  var res = [];
  while (n) {
    res.push(n & 1);
    n >>= 1;
  }
  return res.reverse();
}

var n = parseInt(readline().split());
var a = readline().split(' ').map((x) => parseInt(x));
var maxs = 0;
for (var i = 0; i < n; ++ i) {
  maxs = Math.max(maxs, a[i]);
}
var cnt = new Array(maxs + 1);
var cntSteps = new Array(maxs + 1);
cnt.fill(0);
cntSteps.fill(0);
for (var i = 0; i < n; ++ i) {
  var bits = calcBits(a[i]);
  var num = 0;
  for (var j = 0; j < bits.length; ++ j) {
    var cur = (num << 1) + bits[j];
    ++ cnt[cur];
    cntSteps[cur] += bits.length - j - 1;
    if (num && bits[j] == 1) {
      cur = num << 1;
      for (var k = bits.length - j + 1; cur <= maxs; ++ k, cur <<= 1) {
        ++ cnt[cur];
        cntSteps[cur] += k; 
      }
    }
    num = (num << 1) + bits[j];
  }
  num <<= 1;
  for (var j = 1; num <= maxs; ++ j, num <<= 1) {
    ++ cnt[num];
    cntSteps[num] += j;
  }
}
var ans = 1 << 30;
for (var i = 1; i <= maxs; ++ i) {
  if (cnt[i] == n) {
    ans = Math.min(ans, cntSteps[i]);
  }
}
print(ans);
