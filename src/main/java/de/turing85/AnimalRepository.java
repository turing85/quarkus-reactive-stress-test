package de.turing85;

import io.quarkus.hibernate.reactive.panache.PanacheRepository;
import javax.enterprise.context.ApplicationScoped;
import lombok.AccessLevel;
import lombok.NoArgsConstructor;

@ApplicationScoped
@NoArgsConstructor(access = AccessLevel.PACKAGE)
public class AnimalRepository implements PanacheRepository<Animal> {
}
