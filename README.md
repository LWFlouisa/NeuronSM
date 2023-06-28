# NeuronSM
An example of a neuron state machine.

## Implementation
~~~ruby
def neuron1
  def check_state
    require_relative "Neuron/neuron.rb"
    Neuron::Operate.state
  end

  def transition
    require_relative "Neuron/neuron.rb"
    Neuron::Operate.transition
  end

  check_state
  transition
end

def neuron2
  def check_state
    require_relative "Neuron/neuron.rb"
    Neuron::Operate.state
  end

  def transition
    require_relative "Neuron/neuron.rb"
    Neuron::Operate.transition
  end

  check_state
  transition
end
~~~
