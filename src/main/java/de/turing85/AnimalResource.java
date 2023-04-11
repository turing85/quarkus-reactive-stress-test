package de.turing85;

import io.quarkus.hibernate.reactive.panache.common.WithTransaction;
import io.smallrye.mutiny.Uni;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import java.util.List;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;

@Path("animals")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
@RequiredArgsConstructor(access = AccessLevel.PACKAGE)
public class AnimalResource {
  private final AnimalRepository repository;

  @GET
  public Uni<List<Animal>> listAll() {
    return repository.listAll();
  }

  @GET
  @Path("{id}")
  public Uni<Animal> getById(@PathParam("id") long id) {
    return repository.findById(id);
  }

  @POST
  @WithTransaction
  public Uni<Animal> create(Animal animal) {
    return repository.persist(animal);
  }
}
