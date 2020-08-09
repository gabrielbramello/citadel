module Teams
  module LeavingService
    include BaseService

    def call(user, team)
      team.transaction do
        team.remove_player!(user)
        user.revoke(:edit, team)

        notify_captains(user, team)
      end
    end

    private

    def notify_captains(user, team)
      User.which_can(:edit, team).each do |captain|
        msg = "'#{user.name}' has left the team '#{team.name}'"
        Users::NotificationService.call(captain, message: msg, link: user_path(user))
      end
    end
  end
end
