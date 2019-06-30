class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;
  float hue;

  // ininitialize a certain amount of particles
  ParticleSystem(PVector origin, float hue) {
    this.origin = origin;
    this.hue = hue;
    particles = new ArrayList<Particle>();
  }

  // add a new particle to particles ArrayList
  void addParticle() {
    particles.add(new Particle(origin, hue));
  }

  // move particles and add a new particle for every expired particle.
  void run(float value) { 
    addParticle();
    if (particles.size() > value*20) {
      for (int j = (int)(value*20-1); j >= 0; j--) {
        Particle particle = particles.get(j);
        particle.run(value);
        if (particle.isDead()) {
          particles.remove(particle);
          addParticle();
        }
      }
    }
  }
}
