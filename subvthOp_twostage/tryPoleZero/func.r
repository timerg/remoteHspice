k <- 10^3
x <- 10^6
g <- 10^9
p <- 10^-12
f <- 10^-15
c <- function(f1, f2, c1, c2){(f2*c2-f1*c1)/(f1-f2)}
r <- function(f1, c1, c){1/f1/2/pi/(c1+c)}
p1hz <- function(gm, Ri, Ro, Cc){1/gm/Ri/Ro/Cc/2/pi}
p2hz <- function(gm, Cc, C1, C2){gm*Cc/(C1*C2+C2*Cc+C1*Cc)/2/pi}
