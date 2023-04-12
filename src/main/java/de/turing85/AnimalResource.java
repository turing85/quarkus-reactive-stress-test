package de.turing85;

import io.quarkus.hibernate.reactive.panache.common.runtime.ReactiveTransactional;
import io.smallrye.mutiny.Multi;
import io.smallrye.mutiny.Uni;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;

@Path("animals")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
@RequiredArgsConstructor(access = AccessLevel.PACKAGE)
public class AnimalResource {
  private final AnimalRepository repository;

  @GET
  public Multi<Animal> listAll() {
    return repository.streamAll();
  }

  @GET
  @Path("{id}")
  public Uni<Animal> getById(@PathParam("id") long id) {
    return repository.findById(id);
  }

  @POST
  @ReactiveTransactional
  public Uni<Animal> create(Animal animal) {
    return repository.persist(animal);
  }
}
