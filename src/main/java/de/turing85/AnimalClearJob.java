package de.turing85;

import io.quarkus.hibernate.reactive.panache.common.runtime.ReactiveTransactional;
import io.quarkus.scheduler.Scheduled;
import io.smallrye.mutiny.Uni;
import javax.enterprise.context.ApplicationScoped;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@ApplicationScoped
@RequiredArgsConstructor(access = AccessLevel.PACKAGE)
@Slf4j
public class AnimalClearJob {
  private final AnimalRepository repository;

  @Scheduled(cron = "${db.cleanup.cron}")
  @ReactiveTransactional
  Uni<Void> clearAnimals() {
    return Uni.createFrom().nullItem()
        .onItem().invoke(() -> log.info("clearing animals"))
        .flatMap(ignored -> repository.deleteAll())
        .replaceWithVoid()
        .onItem().invoke(() -> log.info("animals cleared"));
  }
}