# Werdil (Wordle, imma bil-Malti)

Tista' taċċessa l-logħba hawn: https://wordle-malti.github.io/

Magħmulha minn Michael Pulis (https://github.com/michaelpulis)

Kontribuzzjonijiet Oħrajn:
+ Liam Attard (https://github.com/liamattard): 'Share' Feature
+ Sean Diacono (https://github.com/seandiacono): Updated CSS
+ David Schembri (https://ikteb.mt): Qari tal-provi
+ Franco Cassar Manghi (https://github.com/francocm): Refactoring / Bug Fixes

***
Idea meħuda direttament minn https://www.powerlanguage.co.uk/wordle/
***

TODO List: https://github.com/wordle-malti/wordle-malti.github.io/wiki

***

Tista' tħaddem il-logħoba lokalment billi tuża `docker` u `docker-compose` u tagħmel:

```bash
docker-compose up -d 
```

u żur [http://localhost:8080](http://localhost:8080).

***

Biex tiġġenera dizzjunarju ġdid:

> Għandu jkollok `docker` installat biex tuża dan.

1. Iċċekkja li l-URL ġewwa [db/entrypoint.sh](db/entrypoint.sh) huwa ssettjat għall-verżjoni li tixtieq tuża.
2. Fuq sistema li tisapportja Bash (Mac / Linux), eżegwixxi: `./refresh-dictionary.sh`.
    * Jekk qed tuża l-Windows biex tiġġenera dan il-file:
        * Agħmel użu ta' Windows Subsystem for Linux (WSL) u kun ċert li dan il-proġett ġie cloned direttament ġewwa direttorju tal-Linux u mhux Windows (voldieri **mhux** ġo `/mnt/c` iżda x'imkien ieħor). Jaf ukoll jagħti l-każ li jkollok tagħti l-_permission_ `x` _(execute)_ billi tagħmel `chmod +x refresh-dictionary.sh && chmod +x db/entrypoint.sh`, dan minħabba li l-Windows jaf jitlef din l-informazzjoni waqt il-proċess ta' `git clone`.
        * Ara li għandek `bash` disponibbli fl-_environment_ tiegħek.
        * Sempliċiment eżegwixxi l-kmand ta' `docker` li ssib ġewwa [./refresh-dictionary.sh](./refresh-dictionary.sh).

Dan il-proċess idum ftit minuti (3-5 minuti), u jirriżulta f'2 files ġodda jiġu ġġenerati:

* [docs/dictionary.json](docs/dictionary.json) - Fih il-lista kollha ta kliem aċċettati li persuna tista' tikteb.
* [docs/answers.json](docs/answers.json) - Fih il-lista kollha ta kliem li jistgħu jintużaw bħala tweġibiet validi għall-logħoba.

Minkejja li l-files li qed jiġu pproċessati huma akbar minn 1GB+, dan il-proċess juża biss madwar 35MB RAM, għax il-files qed jiġu streamed. Biex dan ikun effiċjenti, qed jintuża l-prinċipju ta' `jsonlines`. Finalment id-dizzjunarju prodott bħala riżultat, hu kbir biss ~120KB.

***

Il-Javascript file [docs/app.js](docs/app.js) qed jiġi mpurtat ġewwa [docs/index.html](docs/index.html) billi jinkludi ukoll suffiss b'numru (eż.: `src="app.js?v=1"`). Ir-raġuni primarja għalfejn din qegħda hemm hi biex iġġiegħel il-browser jerġa' jniżżel dan il-fajl u mhux juża l-_cache_ jekk il-verżjoni tinbidel.

B'hekk, ftakar t'inkrementa dan in-numru jekk tibdel `app.js`, ħalli tisforza l-klijent jerġgħa jniżżlu.

***

## GitHub Pages

Is-sit tiġi ppubblikata awtomatikament fuq GitHub Pages. Minħabba limitazzjonijiet prattiċi ta' GitHub, bħalissa dan qed issettjat li jaqra l-files taħt [docs/](docs/).