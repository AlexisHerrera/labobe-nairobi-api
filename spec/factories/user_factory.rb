module UserFactory
  def an_existing_user
    user_repo = Persistence::Repositories::UsuarioRepository.new
    a_user = User.new('John')
    user_repo.save(a_user)
  end
end
