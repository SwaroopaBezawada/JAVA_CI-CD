package com.example;

import java.util.Objects;

/**
 * Simple utility that returns a greeting message.
 */
public class Greeter {

  /**
   * Creates a new {@code Greeter}.
   */
  public Greeter() {
    // no-op
  }

  /**
   * Returns a greeting for the given name.
   *
   * @param someone name of the person to greet (must not be null)
   * @return greeting message
   * @throws NullPointerException if {@code someone} is null
   */
  public String greet(String someone) {
    Objects.requireNonNull(someone, "someone must not be null");
    return String.format("Hello, %s!", someone);
  }
}
