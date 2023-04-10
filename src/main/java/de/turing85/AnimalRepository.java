package de.turing85;

import io.quarkus.hibernate.reactive.panache.PanacheRepository;
import javax.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class AnimalRepository implements PanacheRepository<Animal> {
}
