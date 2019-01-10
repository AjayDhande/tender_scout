class CreateTenderCollaborationDocument
  include Interactor

  def call
    # unless context.user.admin?
    #   context.fail! errors: { error: :unauthorized, error_description: 'Action is not allowed'},
    #                 code: :unauthorized
    # end

    unless context.tender.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Tender not found'},
                    code: :unprocessable_entity
    end


     if documents_params
       documents_params[:files].each do |k,v|
         document = TenderCollaborationDocument.new(file: v)
         document.user_id = context.current_user.id
         document.collaboration_id = documents_params[:collaboration_id]
         document.tender_id = context.tender.id
         context.fail! errors: document.errors, code: :unprocessable_entity unless document.save
         context.tender.tender_collaboration_documents << document
       end
     end
  end

  private

  def documents_params
    context.params.permit(:collaboration_id, files: {})
  end
end