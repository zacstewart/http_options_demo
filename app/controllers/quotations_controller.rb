class QuotationsController < ApplicationController
  before_filter :authenticate, :only => [:edit, :updated, :destroy]

  # OPTIONS /quotations
  def options
    allow = %w(GET HEAD POST OPTIONS)
    @options = {
      'GET' => {
        description: 'Lists all quotations.'
      }
    }

    respond_to do |format|
      headers['Allow'] = allow.join ','
      format.html
      format.json { render json: @options }
    end
  end

  # OPTIONS /quotation/:id
  def member_options
    allow = %w(GET HEAD OPTIONS)
    @options = {
      'GET' => {
        description: 'Retrieves a representation of a quotation resource.'
      }
    }
    if authenticated?
      allow += %w(DELETE PATCH)
      @options.merge!(
        'DELETE' => {
          description: 'Deletes a quotation resource.'
        },
        'PATCH' => {
          description: 'Modifies a quotation resource',
          parameters: {
            body: {
              description: 'The body of the quotation',
              required: true,
              type: 'string'
            },
            author: {
              description: 'The author of the quotation',
              required: true,
              type: 'string'
            }
          }
        }
      )
    end

    respond_to do |format|
      headers['Allow'] = allow.join ','
      format.html
      format.json { render json: @options }
    end
  end

  # GET /quotations
  # GET /quotations.json
  def index
    @quotations = Quotation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @quotations }
    end
  end

  # GET /quotations/1
  # GET /quotations/1.json
  def show
    @quotation = Quotation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @quotation }
    end
  end

  # GET /quotations/new
  # GET /quotations/new.json
  def new
    @quotation = Quotation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @quotation }
    end
  end

  # GET /quotations/1/edit
  def edit
    @quotation = Quotation.find(params[:id])
  end

  # POST /quotations
  # POST /quotations.json
  def create
    @quotation = Quotation.new(params[:quotation])

    respond_to do |format|
      if @quotation.save
        format.html { redirect_to @quotation, notice: 'Quotation was successfully created.' }
        format.json { render json: @quotation, status: :created, location: @quotation }
      else
        format.html { render action: "new" }
        format.json { render json: @quotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /quotations/1
  # PUT /quotations/1.json
  def update
    @quotation = Quotation.find(params[:id])

    respond_to do |format|
      if @quotation.update_attributes(params[:quotation])
        format.html { redirect_to @quotation, notice: 'Quotation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @quotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotations/1
  # DELETE /quotations/1.json
  def destroy
    @quotation = Quotation.find(params[:id])
    @quotation.destroy

    respond_to do |format|
      format.html { redirect_to quotations_url }
      format.json { head :no_content }
    end
  end
end
