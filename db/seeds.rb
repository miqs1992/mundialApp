User.find_or_initialize_by(login: 'admin').update(first_name: 'Jan', last_name: 'Kowalski', email: 'admin@example.com', password: 'password', password_confirmation: 'password', admin: true)
League.create(name: "Liga ogólna", main: true)

pl = Team.find_or_create_by(name: "Polska", flag: "pl")
ru = Team.find_or_create_by(name: "Rosja", flag: "ru")
fr = Team.find_or_create_by(name: "Francja", flag: "fr")
pt = Team.find_or_create_by(name: "Portugalia", flag: "pt")
de = Team.find_or_create_by(name: "Niemcy", flag: "de")
rs = Team.find_or_create_by(name: "Serbia", flag: "rs")
gb = Team.find_or_create_by(name: "Anglia", flag: "gb")
es = Team.find_or_create_by(name: "Hiszpania", flag: "es")
be = Team.find_or_create_by(name: "Belgia", flag: "be")
is = Team.find_or_create_by(name: "Islandia", flag: "is")
ch = Team.find_or_create_by(name: "Szwajcaria", flag: "ch")
hr = Team.find_or_create_by(name: "Chorwacja", flag: "hr")
dk = Team.find_or_create_by(name: "Dania", flag: "dk")
se = Team.find_or_create_by(name: "Szwecja", flag: "se")
tn = Team.find_or_create_by(name: "Tunezja", flag: "tn")
ng = Team.find_or_create_by(name: "Nigeria", flag: "ng")
ma = Team.find_or_create_by(name: "Maroko", flag: "ma")
sn = Team.find_or_create_by(name: "Senegal", flag: "sn")
eg = Team.find_or_create_by(name: "Egipt", flag: "eg")
ir = Team.find_or_create_by(name: "Iran", flag: "ir")
jp = Team.find_or_create_by(name: "Japonia", flag: "jp")
kr = Team.find_or_create_by(name: "Korea Płd", flag: "kr")
sa = Team.find_or_create_by(name: "Arabia Saudyjska", flag: "sa")
br = Team.find_or_create_by(name: "Brazylia", flag: "br")
uy = Team.find_or_create_by(name: "Urugwaj", flag: "uy")
ar = Team.find_or_create_by(name: "Argentyna", flag: "ar")
co = Team.find_or_create_by(name: "Kolumbia", flag: "co")
mx = Team.find_or_create_by(name: "Meksyk", flag: "mx")
cr = Team.find_or_create_by(name: "Kostaryka", flag: "cr")
pa = Team.find_or_create_by(name: "Panama", flag: "pa")
au = Team.find_or_create_by(name: "Australia", flag: "au")
pe = Team.find_or_create_by(name: "Peru", flag: "pe")

r1 = Round.find_or_create_by(title: "Faza grupowa 1")
r2 = Round.find_or_create_by(title: "Faza grupowa 2")
r3 = Round.find_or_create_by(title: "Faza grupowa 3")
r4 = Round.find_or_create_by(title: "1/8 finału")
r5 = Round.find_or_create_by(title: "Ćwierćfinały")
r6 = Round.find_or_create_by(title: "Półfinały")
r7 = Round.find_or_create_by(title: "Finał")

md1 = MatchDay.find_or_initialize_by(day_number: 1)
md1.update(stop_bet_time: DateTime.new(2018,6,14,15,0,0,"+2"), round: r1)
md1.matches.delete_all
md1.matches.create(city: "Moskwa", start_time: DateTime.new(2018,6,14,17,0,0,"+2"), team1: ru, team2: sa)

md2 = MatchDay.find_or_initialize_by(day_number: 2)
md2.update(stop_bet_time: DateTime.new(2018,6,15,12,0,0,"+2"), round: r1)
md2.matches.delete_all
md2.matches.create(city: "Jekaterynburg", start_time: DateTime.new(2018,6,15,14,0,0,"+2"), team1: eg, team2: uy)
md2.matches.create(city: "St. Petersburg", start_time: DateTime.new(2018,6,15,17,0,0,"+2"), team1: ma, team2: ir)
md2.matches.create(city: "Soczi", start_time: DateTime.new(2018,6,15,20,0,0,"+2"), team1: pt, team2: es)

md3 = MatchDay.find_or_initialize_by(day_number: 3)
md3.update(stop_bet_time: DateTime.new(2018,6,16,10,0,0,"+2"), round: r1)
md3.matches.delete_all
md3.matches.create(city: "Kazań", start_time: DateTime.new(2018,6,16,12,0,0,"+2"), team1: fr, team2: au)
md3.matches.create(city: "Moskwa", start_time: DateTime.new(2018,6,16,15,0,0,"+2"), team1: ar, team2: is)
md3.matches.create(city: "Sarańsk", start_time: DateTime.new(2018,6,16,18,0,0,"+2"), team1: pe, team2: dk)
md3.matches.create(city: "Kaliningrad", start_time: DateTime.new(2018,6,16,21,0,0,"+2"), team1: hr, team2: ng)

md4 = MatchDay.find_or_initialize_by(day_number: 4)
md4.update(stop_bet_time: DateTime.new(2018,6,17,12,0,0,"+2"), round: r1)
md4.matches.delete_all
md4.matches.create(city: "Samara", start_time: DateTime.new(2018,6,17,14,0,0,"+2"), team1: cr, team2: rs)
md4.matches.create(city: "Moskwa", start_time: DateTime.new(2018,6,17,17,0,0,"+2"), team1: de, team2: mx)
md4.matches.create(city: "Rostów", start_time: DateTime.new(2018,6,17,20,0,0,"+2"), team1: br, team2: ch)

md5 = MatchDay.find_or_initialize_by(day_number: 5)
md5.update(stop_bet_time: DateTime.new(2018,6,18,12,0,0,"+2"), round: r1)
md5.matches.delete_all
md5.matches.create(city: "Niżny Nowogród", start_time: DateTime.new(2018,6,18,14,0,0,"+2"), team1: se, team2: kr)
md5.matches.create(city: "Soczi", start_time: DateTime.new(2018,6,18,17,0,0,"+2"), team1: be, team2: pa)
md5.matches.create(city: "Wołgograd", start_time: DateTime.new(2018,6,18,20,0,0,"+2"), team1: tn, team2: gb)

md6 = MatchDay.find_or_initialize_by(day_number: 6)
md6.update(stop_bet_time: DateTime.new(2018,6,19,12,0,0,"+2"), round: r1)
md6.matches.delete_all
md6.matches.create(city: "Sarańsk", start_time: DateTime.new(2018,6,19,14,0,0,"+2"), team1: co, team2: jp)
md6.matches.create(city: "Moskwa", start_time: DateTime.new(2018,6,19,17,0,0,"+2"), team1: pl, team2: sn)
md6.matches.create(city: "St. Petersburg", start_time: DateTime.new(2018,6,19,20,0,0,"+2"), team1: ru, team2: eg)

#r2
md7 = MatchDay.find_or_initialize_by(day_number: 7)
md7.update(stop_bet_time: DateTime.new(2018,6,20,12,0,0,"+2"), round: r2)
md7.matches.delete_all
md7.matches.create(city: "Moskwa", start_time: DateTime.new(2018,6,20,14,0,0,"+2"), team1: pt, team2: ma)
md7.matches.create(city: "Rostów", start_time: DateTime.new(2018,6,20,17,0,0,"+2"), team1: uy, team2: sa)
md7.matches.create(city: "Kazań", start_time: DateTime.new(2018,6,20,20,0,0,"+2"), team1: ir, team2: es)

md8 = MatchDay.find_or_initialize_by(day_number: 8)
md8.update(stop_bet_time: DateTime.new(2018,6,21,12,0,0,"+2"), round: r2)
md8.matches.delete_all
md8.matches.create(city: "Samara", start_time: DateTime.new(2018,6,21,14,0,0,"+2"), team1: dk, team2: au)
md8.matches.create(city: "Jekaterynburg", start_time: DateTime.new(2018,6,21,17,0,0,"+2"), team1: fr, team2: pe)
md8.matches.create(city: "Niżny Nowogród", start_time: DateTime.new(2018,6,21,20,0,0,"+2"), team1: ar, team2: hr)

md9 = MatchDay.find_or_initialize_by(day_number: 9)
md9.update(stop_bet_time: DateTime.new(2018,6,22,12,0,0,"+2"), round: r2)
md9.matches.delete_all
md9.matches.create(city: "St. Petersburg", start_time: DateTime.new(2018,6,22,14,0,0,"+2"), team1: br, team2: cr)
md9.matches.create(city: "Wołgorad", start_time: DateTime.new(2018,6,22,17,0,0,"+2"), team1: ng, team2: is)
md9.matches.create(city: "Kaliningrad", start_time: DateTime.new(2018,6,22,20,0,0,"+2"), team1: rs, team2: ch)

md10 = MatchDay.find_or_initialize_by(day_number: 10)
md10.update(stop_bet_time: DateTime.new(2018,6,23,12,0,0,"+2"), round: r2)
md10.matches.delete_all
md10.matches.create(city: "Moskwa", start_time: DateTime.new(2018,6,23,14,0,0,"+2"), team1: be, team2: tn)
md10.matches.create(city: "Rostów", start_time: DateTime.new(2018,6,23,17,0,0,"+2"), team1: kr, team2: mx)
md10.matches.create(city: "Soczi", start_time: DateTime.new(2018,6,23,20,0,0,"+2"), team1: de, team2: se)

md11 = MatchDay.find_or_initialize_by(day_number: 11)
md11.update(stop_bet_time: DateTime.new(2018,6,24,12,0,0,"+2"), round: r2)
md11.matches.delete_all
md11.matches.create(city: "Niżny Nowogród", start_time: DateTime.new(2018,6,24,14,0,0,"+2"), team1: gb, team2: pa)
md11.matches.create(city: "Jekaterynburg", start_time: DateTime.new(2018,6,24,17,0,0,"+2"), team1: jp, team2: se)
md11.matches.create(city: "Kazań", start_time: DateTime.new(2018,6,24,20,0,0,"+2"), team1: pl, team2: co)

#r3
md12 = MatchDay.find_or_initialize_by(day_number: 12)
md12.update(stop_bet_time: DateTime.new(2018,6,25,14,0,0,"+2"), round: r3)
md12.matches.delete_all
md12.matches.create(city: "Niżny Nowogród", start_time: DateTime.new(2018,6,25,16,0,0,"+2"), team1: sa, team2: eg)
md12.matches.create(city: "Jekaterynburg", start_time: DateTime.new(2018,6,25,16,0,0,"+2"), team1: uy, team2: ru)
md12.matches.create(city: "Kazań", start_time: DateTime.new(2018,6,25,20,0,0,"+2"), team1: ir, team2: pt)
md12.matches.create(city: "Kazań", start_time: DateTime.new(2018,6,25,20,0,0,"+2"), team1: es, team2: ma)

md13 = MatchDay.find_or_initialize_by(day_number: 13)
md13.update(stop_bet_time: DateTime.new(2018,6,26,14,0,0,"+2"), round: r3)
md13.matches.delete_all
md13.matches.create(city: "Niżny Nowogród", start_time: DateTime.new(2018,6,26,16,0,0,"+2"), team1: au, team2: pe)
md13.matches.create(city: "Jekaterynburg", start_time: DateTime.new(2018,6,26,16,0,0,"+2"), team1: dk, team2: fr)
md13.matches.create(city: "Kazań", start_time: DateTime.new(2018,6,26,20,0,0,"+2"), team1: ng, team2: ar)
md13.matches.create(city: "Kazań", start_time: DateTime.new(2018,6,26,20,0,0,"+2"), team1: is, team2: hr)

md14 = MatchDay.find_or_initialize_by(day_number: 14)
md14.update(stop_bet_time: DateTime.new(2018,6,27,14,0,0,"+2"), round: r3)
md14.matches.delete_all
md14.matches.create(city: "Niżny Nowogród", start_time: DateTime.new(2018,6,27,16,0,0,"+2"), team1: kr, team2: de)
md14.matches.create(city: "Jekaterynburg", start_time: DateTime.new(2018,6,27,16,0,0,"+2"), team1: mx, team2: se)
md14.matches.create(city: "Kazań", start_time: DateTime.new(2018,6,27,20,0,0,"+2"), team1: ch, team2: cr)
md14.matches.create(city: "Kazań", start_time: DateTime.new(2018,6,27,20,0,0,"+2"), team1: is, team2: hr)

md15 = MatchDay.find_or_initialize_by(day_number: 15)
md15.update(stop_bet_time: DateTime.new(2018,6,28,14,0,0,"+2"), round: r3)
md15.matches.delete_all
md15.matches.create(city: "Niżny Nowogród", start_time: DateTime.new(2018,6,28,16,0,0,"+2"), team1: sn, team2: co)
md15.matches.create(city: "Jekaterynburg", start_time: DateTime.new(2018,6,28,16,0,0,"+2"), team1: jp, team2: pl)
md15.matches.create(city: "Kazań", start_time: DateTime.new(2018,6,28,20,0,0,"+2"), team1: gb, team2: be)
md15.matches.create(city: "Kazań", start_time: DateTime.new(2018,6,28,20,0,0,"+2"), team1: pa, team2: tn)

md16 = MatchDay.find_or_initialize_by(day_number: 16)
md16.update(stop_bet_time: DateTime.new(2018,6,30,14,0,0,"+2"), round: r4)

md17 = MatchDay.find_or_initialize_by(day_number: 17)
md17.update(stop_bet_time: DateTime.new(2018,7,1,14,0,0,"+2"), round: r4)

md18 = MatchDay.find_or_initialize_by(day_number: 18)
md18.update(stop_bet_time: DateTime.new(2018,7,2,14,0,0,"+2"), round: r4)

md19 = MatchDay.find_or_initialize_by(day_number: 19)
md19.update(stop_bet_time: DateTime.new(2018,7,3,14,0,0,"+2"), round: r4)

md20 = MatchDay.find_or_initialize_by(day_number: 20)
md20.update(stop_bet_time: DateTime.new(2018,7,6,14,0,0,"+2"), round: r5)

md21 = MatchDay.find_or_initialize_by(day_number: 21)
md21.update(stop_bet_time: DateTime.new(2018,7,7,14,0,0,"+2"), round: r5)

md22 = MatchDay.find_or_initialize_by(day_number: 22)
md22.update(stop_bet_time: DateTime.new(2018,7,10,18,0,0,"+2"), round: r6)

md23 = MatchDay.find_or_initialize_by(day_number: 23)
md23.update(stop_bet_time: DateTime.new(2018,7,11,18,0,0,"+2"), round: r6)

md24 = MatchDay.find_or_initialize_by(day_number: 24)
md24.update(stop_bet_time: DateTime.new(2018,7,14,14,0,0,"+2"), round: r7)

md25 = MatchDay.find_or_initialize_by(day_number: 25)
md25.update(stop_bet_time: DateTime.new(2018,7,15,15,0,0,"+2"), round: r7)

#poland
Player.create(number:7,	first_name: "Arkadiusz", last_name: "Milik", team: pl)
Player.create(number:9,	first_name: "Robert", last_name: "Lewandowski", team: pl)
Player.create(number:16, first_name: "Jakub", last_name: "Błaszczykowski", team: pl)

#other
Player.create(number:10, first_name: "Mohamed", last_name: "Salah", team: eg)
Player.create(number:9, first_name: "Luis", last_name: "Suarez", team: uy)
Player.create(number:21, first_name: "Edison", last_name: "Cavani", team: uy)
Player.create(number:7, first_name: "Cristiano", last_name: "Ronaldo", team: pt)
Player.create(number:21, first_name: "David", last_name: "Silva", team: es)
Player.create(number:19, first_name: "Diego", last_name: "Costa", team: es)
Player.create(number:4, first_name: "Tim", last_name: "Cahill", team: au)
Player.create(number:10, first_name: "Christian", last_name: "Eriksen", team: dk)
Player.create(number:7, first_name: "Antoine", last_name: "Griezmann", team: fr)
Player.create(number:9, first_name: "Olivier", last_name: "Giroud", team: fr)
Player.create(number:6, first_name: "Paul", last_name: "Pogba", team: fr)
Player.create(number:10, first_name: "Lionel", last_name: "Messi", team: ar)
Player.create(number:9, first_name: "Gonzalo", last_name: "Higuaín", team: ar)
Player.create(number:19, first_name: "Sergio", last_name: "Agüero", team: ar)
Player.create(number:17, first_name: "Mario", last_name: "Mandžukić", team: hr)
Player.create(number:9, first_name: "Gabriel", last_name: "Jesus", team: br)
Player.create(number:10, first_name: "Neymar", last_name: "da Silva Santos Júnior", team: br)
Player.create(number:13, first_name: "Thomas", last_name: "Müller", team: de)
Player.create(number:23, first_name: "Mario", last_name: "Gomez", team: de)
Player.create(number:9, first_name: "Timo", last_name: "Werner", team: de)
Player.create(number:14, first_name: "Javier", last_name: "Hernández", team: mx)
Player.create(number:7, first_name: "Kevin", last_name: "De Bruyne", team: be)
Player.create(number:8, first_name: "Marouane", last_name: "Fellaini", team: be)
Player.create(number:9, first_name: "Romelu", last_name: "Lukaku", team: be)
Player.create(number:10, first_name: "Eden", last_name: "Hazard", team: be)
Player.create(number:9, first_name: "Harry", last_name: "Kane", team: gb)
Player.create(number:7, first_name: "Blas", last_name: "Pérez", team: pa)
Player.create(number:18, first_name: "Luis", last_name: "Tejada", team: pa)
Player.create(number:9, first_name: "Falcao", last_name: "Falcao", team: co)
Player.create(number:10, first_name: "James", last_name: "Rodríguez", team: co)