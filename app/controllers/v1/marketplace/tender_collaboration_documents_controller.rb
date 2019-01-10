class V1::Marketplace::TenderCollaborationDocumentsController < ApplicationController
  before_action :set_tender
  before_action :set_document, only: [:destroy]

  def index
    collaboration = ::Marketplace::TenderCollaborator.where(collaboration: Marketplace::Collaboration.where(tender: @tender.id), user: current_user.id).first.collaboration
    render json: @tender.tender_collaboration_documents.where(collaboration_id: collaboration.id)
  end

  def create
    result = CreateTenderCollaborationDocument.call(params: documents_params, tender: @tender,
                                                    current_user: current_user)
    if result.success?
       render json: result.tender.tender_collaboration_documents, status: :created
     else
       render json: result.errors, status: result.code
     end
  end

  def destroy
    unless @tender.tender_collaboration_documents.delete(@document)
      render json: {
          error: :service_unavailable,
          error_description: 'Attachment was not deleted from S3'
      },
             status: :service_unavailable
    end
    render json: @document.errors, status: :unprocessable_entity unless @document.destroy
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_tender
    @tender = Core::Tender.find(params[:tender_id])
  end

  def set_document
    @document = TenderCollaborationDocument.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def documents_params
    params.permit(:collaboration_id, files: {} )
  end
end
