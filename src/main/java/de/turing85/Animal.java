package de.turing85;

import io.quarkus.hibernate.reactive.panache.PanacheEntityBase;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "animals")
@NoArgsConstructor
@Getter
@Setter
public class Animal extends PanacheEntityBase {
  @Id
  @SequenceGenerator(
      name = "animalSequenceGenerator",
      sequenceName = "animals__seq__id")
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "animalSequenceGenerator")
  @Column(name = "id")
  Long id;

  @Column(name = "name", unique = true)
  String name = "";

  @Column(name = "species")
  String species = "";
}