class PokemonsController < ApplicationController
   def new
    curr_pokemon = Pokemon.new
  end

  def create
    curr_pokemon = Pokemon.new(pokemon_params)
    curr_pokemon.trainer_id = current_trainer.id
    curr_pokemon.level = 1
    curr_pokemon.health = 100
    if curr_pokemon.save
      redirect_to trainer_path(id: current_trainer.id)
    else
      redirect_to new_path, :flash => { :error => "Give your pokemon a unique name!"}
    end 
  end

  def capture
    curr_pokemon = Pokemon.find(params[:id])
    curr_pokemon.trainer = current_trainer
    curr_pokemon.save
    redirect_to root_path
  end

  def damage
    curr_pokemon = Pokemon.where(id: params[:id]).first
    if curr_pokemon.health != nil
      curr_pokemon.health = curr_pokemon.health - 10
    end
    if curr_pokemon.health <= 0
      curr_pokemon.destroy
    else
      curr_pokemon.save
    end

    redirect_to trainer_path(icurrent_trainer.id)
  end

private
    def pokemon_params
      params.require(:pokemon).permit(:name, :ndex)
    end
end