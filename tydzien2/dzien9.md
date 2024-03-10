# Tydzień 2: Docker & Homelab 🚀

## Dzień 9: Podstawowe Komendy Docker 🐳

### Zarządzanie kontenerami z linii poleceń

Dzisiaj skupimy się na podstawowych komendach Docker, które są niezbędne do zarządzania kontenerami. Poznanie tych komend pozwoli na efektywne zarządzanie cyklem życia kontenerów.

## Najważniejsze komendy Docker:

### 1. Uruchamianie kontenera:
Uruchamia nowy kontener z określonego obrazu. Możesz użyć opcji, takich jak `-d` dla trybu odłączonego (detached) czy `-p` do mapowania portów.
```
docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
```
2. Wylistowanie kontenerów:
Pokazuje działające kontenery. Użyj docker ps -a aby zobaczyć wszystkie kontenery (również zatrzymane).
```
docker ps [OPTIONS]
```
3. Zatrzymywanie kontenera:
Zatrzymuje jeden lub więcej działających kontenerów.
```
docker stop [OPTIONS] CONTAINER [CONTAINER...]
```    
4. Uruchamianie zatrzymanego kontenera:
Uruchamia jeden lub więcej zatrzymanych kontenerów.
```
docker start [OPTIONS] CONTAINER [CONTAINER...]
```
5. Usuwanie kontenera:
Usuwa jeden lub więcej kontenerów. Kontenery muszą być zatrzymane, aby mogły być usunięte.
```
docker rm [OPTIONS] CONTAINER [CONTAINER...]
```
6. Wyświetlanie logów kontenera:
Pozwala na dostęp do logów kontenera. Bardzo przydatne przy debugowaniu i monitorowaniu aplikacji.
```
docker logs [OPTIONS] CONTAINER
```
7. Wykonanie polecenia w działającym kontenerze:
Uruchamia polecenie w działającym kontenerze. Przydatne do interakcji z aplikacją lub zarządzania konfiguracją.
```
docker exec [OPTIONS] CONTAINER COMMAND [ARG...]
```

Przykład użycia:
Załóżmy, że chcemy uruchomić kontener z nginx, udostępnić go na porcie 8080 i zobaczyć logi startu:

```
docker run -d -p 8080:80 --name my-nginx nginx
```
```
docker logs my-nginx
```

Następnie, jeśli chcemy zatrzymać i usunąć nasz kontener:

```
docker stop my-nginx
```
```
docker rm my-nginx
```

Podsumowanie:
Znajomość podstawowych komend Docker jest kluczowa dla każdego, kto pracuje z konteneryzacją. Pozwala na szybkie tworzenie, zarządzanie i debugowanie kontenerów, co jest nieocenione w codziennej pracy z aplikacjami. 🚀