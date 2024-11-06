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

int get_rating(ii cell, int n)
{
  if (!in_bound(cell, 0, n - 1) or visited[cell.first][cell.second])
    return -1;
  int sum = 0;
  ii knight_move[] = {{1, 2}, {-1, 2}, {1, -2}, {-1, -2}, {2, 1}, {2, -1}, {-2, 1}, {-2, -1}};
  forn(i, 8)
  {
    ii possible_move = pair_sum(cell, knight_move[i]);
    if (in_bound(possible_move, 0, n - 1) and !visited[possible_move.first][possible_move.second])
      sum++;
  }
  return sum;
}


vector<ii> solve_knight_tour(int n)
{
  // There are no knight tours for n<=4
  if (n <= 4)
    return vector<ii>();

  vector<ii> knight_tour;

  ii pos(random_between(0,n-1), random_between(0,n-1));

  if(n & 1)
    pos = mkp((n-1)*random_between(0,1),(n-1)*random_between(0,1));

  knight_tour.pb(pos);

  ii knight_move[] = {{1, 2}, {-1, 2}, {1, -2}, {-1, -2}, {2, 1}, {2, -1}, {-2, 1}, {-2, -1}};

  rforn(cells, n * n)
  {
    // Blind alley
    if(visited[pos.first][pos.second])
      return knight_tour;
    visited[pos.first][pos.second] = true;
    ii next_cell(-1, -1);
    int min_rating = INF;
    forn(i, 8)
    {
      ii posible_move = pair_sum(pos, knight_move[i]);
      int cell_rating = get_rating(posible_move, n);
      if (cell_rating != -1 and cell_rating < min_rating)
      {
        next_cell = posible_move;
        min_rating = cell_rating;
      }
    }

    // Blind alley
    if (min_rating == INF)
      return knight_tour;
      knight_tour.pb(next_cell);

    pos = next_cell;
  }

 return knight_tour;
}