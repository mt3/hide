module Hide
  class GitError < Exception; end

  class Git

    def initialize(path, sha1, sha2)
      @path, @sha1, @sha2 = path, sha1, sha2
    end

    def changed_files
      @changed_files ||= begin
        command = %Q[log --no-merges --pretty="format:%H :|: %s" --stat --name-only --no-color #{@sha1}..#{@sha2}]
        output  = in_repo(command)
        parse output
      end
    end

    def in_repo command
      output = %x[git --git-dir=#{@path}/.git --work-tree=#{@path} #{command} 2>&1]
      raise GitError, output unless $?.success?
      output
    end

    def parse output
      output.split(/\n\n/).map do |commit|
        lines = commit.split("\n")
        sha   = lines.shift.split(':|:').shift.strip
        files = lines
        # { :sha => sha, :files => files }
        files
      end.flatten
    end

    def update_repo
      STDERR.puts "Updating repository..."
      in_repo('fetch')
      in_repo("reset origin/#{Hide.config(:branch)} --hard")
    end

  end
end
