#include <bits/stdc++.h>

using namespace std;

#define maxn 510
#define inf 2000000000
#define ll long long
#define maxx 1000010

int N, M, S, D;
int Drum, L;
vector <int> A[maxn];
int G[maxn], Dist[maxn], From[maxn];
int Q[maxx], U[maxn];
int C[maxn][maxn], F[maxn][maxn], Cost[maxn][maxn];

int BellmanFord()
{
	int i, j;

	for (i = 1; i <= N; i++)
	{

		Dist[i] = inf;
		From[i] = -1;
	}

	Dist[S] = 0;
	L = 1;
	Q[L] = S;
	memset(U, 0, sizeof(U));
	U[S] = 1;

	for (i = 1; i <= L; i++)
	{
		for (j=0; j<G[Q[i]]; j++)
			if (C[Q[i]][A[Q[i]][j]]-F[Q[i]][A[Q[i]][j]]>0 && Dist[Q[i]]+Cost[Q[i]][A[Q[i]][j]]<Dist[A[Q[i]][j]])
			{
				Dist[A[Q[i]][j]] = Dist[Q[i]] + Cost[Q[i]][A[Q[i]][j]];
				From[A[Q[i]][j]] = Q[i];
				if (!U[A[Q[i]][j]])
				{
					Q[++L] = A[Q[i]][j];
					U[Q[L]] = 1;
				}
			}

		U[Q[i]] = 0;
	}

	if (Dist[D] != inf)
	{
		int Vmin = inf;
		Drum = 1;

		for (i = D; i != S; i = From[i]) Vmin = min(Vmin, C[From[i]][i] - F[From[i]][i]);

		for (i = D; i != S; i = From[i])
		{
			F[From[i]][i] += Vmin;
			F[i][From[i]] -= Vmin;
		}

		return Vmin * Dist[D];
	}

	return 0;
}

ll Flux()
{
	ll Rez = 0;
	Drum = 1;

	while (Drum)
	{
		Drum = 0;
		Rez += BellmanFord();
	}

	return Rez;
}

int main()
{
	freopen("fmcm.in", "r", stdin);
	freopen("fmcm.out", "w", stdout);

	int i, x, y, z, cap;

	scanf("%d %d %d %d ", &N, &M, &S, &D);

	for (i = 1; i <= M; i++)
	{
		scanf("%d %d %d %d ", &x, &y, &cap, &z);

		A[x].push_back(y);
		A[y].push_back(x);

		C[x][y] = cap;
		Cost[x][y] = z;
		Cost[y][x] = -z;
	}

	for (i = 1; i <= N; i++) G[i] = A[i].size();

	printf("%lld\n", Flux());

	return 0;
}
