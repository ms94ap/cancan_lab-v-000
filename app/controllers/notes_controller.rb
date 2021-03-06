class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource only: [:edit, :show, :update]

  def new
    render partial: 'form', locals: {note: Note.new}
  end

  def create
    note = Note.new(note_params)
    note.user = current_user
    note.save!
    redirect_to '/'
  end

  def update
    @note.update(note_params)
    redirect_to '/'
  end

  def edit
  end

  def show
  end

  def index
    @notes = Note.none
    if current_user
      @notes = current_user.readable
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:content, :visible_to)
    end

end
