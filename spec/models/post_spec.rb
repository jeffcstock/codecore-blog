require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it 'requires post title' do
      p = Post.new(body: 'Hey Jude')
      p.valid?
      expect(p.errors.messages).to have_key(:title)
    end
    it 'requires post title to be 7 characters or more' do
      p = Post.new(title: 'ks', body: 'My body')
      p.valid?
      expect(p.errors).to have_key(:title)
    end
    it 'requires post body' do
      p = Post.new(title: 'My new Post')
      p.valid?
      expect(p.errors).to have_key(:body)
    end
  end
  describe 'body_snippet' do
    it 'requires body to shorten if over 100 characters' do
      p = Post.new(title: 'My new post', body: 'Bacon corned beef shoulder, pancetta turducken bresaola prosciutto ham hock pastrami filet mignon cow. Flank shankle chicken fatback, corned beef frankfurter hamburger bacon shank alcatra turducken ball tip strip steak prosciutto drumstick. Salami corned beef drumstick shank, tongue short loin ham tri-tip cupim. Pork chop fatback pork belly sirloin kevin biltong pastrami. Pork drumstick corned beef hamburger burgdoggen, bacon rump ground round bresaola chicken boudin. Kielbasa cupim drumstick, pastrami bacon beef ribs ham.')
      result = p.body_snippet
      expect(result.length).to equal(103)
    end
  end
end
