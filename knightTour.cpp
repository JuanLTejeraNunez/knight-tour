#include <bits/stdc++.h>

#define forr(i, a, b) for (int i = a; i < b; i++)
#define forn(i, n) forr(i, 0, n)
#define rforr(i, a, b) for (int i = b - 1; i >= a; i--)
#define rforn(i, n) rforr(i, 0, n)
#define db(v) cout << #v << " = " << (v) << '\n';
#define bn '\n'
#define pb(v) push_back(v)
#define mkp(i, j) make_pair(i, j)
#define pow2(x) ((x) * (x))
#define med(a, b) ((a + b) / 2)
using namespace std;

#define IOS_HACK               \
  ios::sync_with_stdio(false); \
  cin.tie(nullptr);            \
  cout.tie(nullptr);

#ifndef ONLINE_JUDGE
#define FREOPEN                             \
  assert(freopen("input.txt", "r", stdin)); \
  assert(freopen("output.txt", "w", stdout));
#else
#define FREOPEN ;
#endif

using ll = long long;
using ui = unsigned int;
using ii = pair<int, int>;
using ull = unsigned long long;
using vi = vector<int>;
using vii = vector<ii>;
using llp = pair<ll, ll>;

const ll MAXN = 1e4 + 100, MAXM = 100 + 100, LOG_MAXN = 20, MAXVAL = 2e6 + 100,
         MOD = 1e9 + 7, INF = 1e9 + 7;

template <class A, class B>
ostream &operator<<(ostream &strm, pair<A, B> p)
{
  return strm << "{" << p.first << ";" << p.second << "}";
}

int random_between(int a, int b)
{
  return rand() % (b + 1 - a) + a;
}

ii pair_sum(ii &a, ii b)
{
  return mkp(a.first + b.first, a.second + b.second);
}

bool in_bound(ii p, int a, int b)
{
  return (a <= p.first and p.first <= b and a <= p.second and p.second <= b);
}

bool visited[MAXN][MAXN];