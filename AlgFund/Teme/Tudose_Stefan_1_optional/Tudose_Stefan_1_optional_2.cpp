#include <bits/stdc++.h>
using namespace std;

ifstream fin("padure.in");
ofstream fout("padure.out");

int n, m, pl, pc, cc, cl, i, j;


int main(){
	const int maxx = 2147483647;

	fin >> n >> m >> pl >> pc >> cl >> cc;
	--pl; --pc; --cl; --cc;
	pair <int, int> pad[n*m];
	pair <int, int> deSetuit[n*m];
	for (i = 0; i < n; ++i){
		for (j = 0; j < m; ++j){
			fin >> pad[i*m+j].second;           ///pad[ceva].first = dist pana aici .second = pozitia
			pad[i*m+j].first = maxx;
            deSetuit[i*m+j].first = maxx;
            deSetuit[i*m+j].second = i*m+j;
		}
	}
	pad[pl*m+pc].first = 0;
	deSetuit[pl*m+pc].first = 0;
	set <pair <int, int>> dist(deSetuit, deSetuit + n * m);

	pair <int, int> aici;
	while (!dist.empty()){
        aici = *dist.begin();         /// aici .first = distanta pana aici; .second = pozitia
        if (aici.first == maxx)
            break;
        dist.erase(aici);
        if (aici.second - m >= 0){              ///sus
            if (pad[aici.second].second!=pad[aici.second-m].second){
                if (aici.first + 1 < pad[aici.second-m].first){
                    ///dist.erase(make_pair(pad[aici.second-m].first, aici.second-m));
                    pad[aici.second-m].first = aici.first + 1;
                    dist.insert(make_pair(pad[aici.second-m].first, aici.second-m));

                }
            }
            else{
                if (aici.first + 0 < pad[aici.second-m].first){
                    ///dist.erase(make_pair(pad[aici.second-m].first, aici.second-m));
                    pad[aici.second-m].first = aici.first + 0;
                    dist.insert(make_pair(pad[aici.second-m].first, aici.second-m));
                }
            }
        }
        if (aici.second % m != 0){              ///stanga
            if (pad[aici.second].second!=pad[aici.second-1].second){
                if (aici.first + 1 < pad[aici.second-1].first){
                    ///dist.erase(make_pair(pad[aici.second-1].first, aici.second-1));
                    pad[aici.second-1].first = aici.first + 1;
                    dist.insert(make_pair(pad[aici.second-1].first, aici.second-1));

                }
            }
            else{
                if (aici.first + 0 < pad[aici.second-1].first){
                    ///dist.erase(make_pair(pad[aici.second-1].first, aici.second-1));
                    pad[aici.second-1].first = aici.first + 0;
                    dist.insert(make_pair(pad[aici.second-1].first, aici.second-1));
                }
            }
        }
        if ((aici.second + 1) % m != 0){                  ///dreapta
            if (pad[aici.second].second!=pad[aici.second+1].second){
                if (aici.first + 1 < pad[aici.second+1].first){
                    ///dist.erase(make_pair(pad[aici.second+1].first, aici.second+1));
                    pad[aici.second+1].first = aici.first + 1;
                    dist.insert(make_pair(pad[aici.second+1].first, aici.second+1));

                }
            }
            else{
                if (aici.first + 0 < pad[aici.second+1].first){
                    ///dist.erase(make_pair(pad[aici.second+1].first, aici.second+1));
                    pad[aici.second+1].first = aici.first + 0;
                    dist.insert(make_pair(pad[aici.second+1].first, aici.second+1));
                }
            }
        }
        if (aici.second + m <= n*m-1){                  ///jos
            if (pad[aici.second].second!=pad[aici.second+m].second){
                if (aici.first + 1 < pad[aici.second+m].first){
                    ///dist.erase(make_pair(pad[aici.second+m].first, aici.second+m));
                    pad[aici.second+m].first = aici.first + 1;
                    dist.insert(make_pair(pad[aici.second+m].first, aici.second+m));
                }
            }
            else{
                if (aici.first + 0 < pad[aici.second+m].first){
                    pad[aici.second+m].first = aici.first + 0;
                    dist.insert(make_pair(pad[aici.second+m].first, aici.second+m));
                }
            }
        }
        if (aici.second== cl*m+cc)
            break;
	}/*
	for (i = 0; i < n; ++i){
        for (j = 0; j < m; ++j)
            fout << pad[i*m+j].first << ' ';
        fout << '\n';
	}*/
	fout << pad[cl*m+cc].first << '\n';
    return 0;
}