class LettersController < ApplicationController
  def create
    @letter = Letter.new(letter_params)
    respond_to do |format|
      if @letter.save
        format.json { render json: {}, status: :ok }
      else
        format.js { render :errors }
      end
    end
  end

  private

  def letter_params
    params.require(:letter).permit(:letter_text)
  end
end
