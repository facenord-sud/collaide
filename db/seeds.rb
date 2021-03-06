# -*- encoding : utf-8 -*-
# This fichier should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

I18n.locale = :fr
Document::Type.create([
    {name: 'Présentation', description: 'A compléter'},
    {name: 'Rapport', description: 'A compléter'},
    {name: 'Travail de maturité', description: 'A compléter'},
    {name: 'Analyse', description: 'A compléter'},
    {name: 'Résumé', description: 'A compléter'},
    {name: 'Corrigé', description: 'A compléter'},
    {name: 'Test', description: 'A compléter'},
    {name: 'Dossier', description: 'A compléter'},
    {name: 'Biographie', description: 'A compléter'},
    {name: 'Note de cours', description: 'A compléter'},
    {name: 'Travail de Maturité', description: 'A compléter'},
    {name: '', description: 'A compléter'},
    {name: 'Réponses exa', description: 'A compléter'},
    {name: 'Annale d\'examen', description: 'A compléter'}
])
User.create([
    {name: 'admin', email: 'admin@example.com', password: 'password', role: :super_admin},
    {name: 'user', email: 'user@example.com', password: 'password'}
            ])
Domain.create([
    {name: 'domain 1', description: 'premier domaine', position: 0},
    {name: 'domain 2', description: 'deuxième domaine', position: 1}
              ])
Document::Document.create([
                              {"title"=>"Doc 1", "description"=>"c'est une déscription 1", "author"=>"salut", "number_of_pages"=>"2", "realized_at"=>"2012-01-24", "language"=>"Français", "asset"=>Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'download', 'asDF.tiff')), "document_type_id"=>"1",  "study_level"=>"university", domain_ids: [1]},
                              {"title"=>"Doc 2", "description"=>"c'est une déscription 2", "author"=>"salut", "number_of_pages"=>"23", "realized_at"=>"2012-01-25", "language"=>"Français", "asset"=>Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'download', 'asDF.tiff')), "document_type_id"=>"1",  "study_level"=>"university", domain_ids: [1]}
                          ])
