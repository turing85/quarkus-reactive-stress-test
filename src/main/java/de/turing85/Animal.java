package de.turing85;

import io.quarkus.hibernate.reactive.panache.PanacheEntityBase;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "animals", schema = "public")
@NoArgsConstructor
@Getter
@Setter
public class Animal extends PanacheEntityBase {
  @Id
  @SequenceGenerator(
      name = "animalSequenceGenerator",
      schema = "public",
      sequenceName = "animals__seq__id")
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "animalSequenceGenerator")
  @Column(name = "id")
  Long id;

  @Column(name = "name", length = 63, nullable = false, unique = true)
  String name = "";

  @Column(name = "species", length = 63, nullable = false)
  String species = "";
}