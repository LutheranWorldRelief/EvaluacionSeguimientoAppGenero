class UserAnswers

  # constructor
  def initialize(user_email, survey_id, counter)
    @user_email = user_email
    @survey = survey_id
    @count = counter

    @user = User.where(email: @user_email).last
    @survey = Survey.find(survey_id)
    @sections = @survey.sections
    @answers = Answer.eager_load(:question)
                     .where(user_email: user_email,
                            survey: survey_id,
                            counter: counter).order('answers.id ASC')

    @answers_mapped = @answers.group_by do
      |answer| answer.question.section_id
    end

    @answers_mapped_questions = @answers_mapped.map {
      |k, ans|
      [k, ans.map { |a| [a.question_id, a.answer_question] }.to_h ]
    }.to_h

    @answers_mapped = @answers_mapped.map {
      |k, ans|
      [k, ans.map { |a| a.answer_question }]
    }.to_h
  end

  def barchar_colors
    ["#9FD52E", "#666"]
  end

  def piechart_colors
    ["#9FD52E", "#666"]
  end

  def by_section_id_question_id(section_id, question_id)
    section = @answers_mapped_questions[section_id] || {}
    section[question_id] || false
  end

  def by_section_id(section_id)
    @answers_mapped[section_id] || []
  end

  def by_section(section)
    by_section_id(section.id)
  end

  def section_include(section, value)
    section_id_include(section.id, value)
  end

  def section_id_include(section_id, value)
    by_section_id(section_id).include?(value)
  end

  def section_gab(section)
    section_id_gab(section.id)
  end

  def section_men(section)
    section_id_men(section.id)
  end

  def section_id_men(section_id)
    by_section_id(section_id)[0]
  end

  def section_id_women(section_id)
    by_section_id(section_id)[1]
  end

  def section_women(section)
    section_id_women(section.id)
  end

  def section_id_gab(section_id)
    unless section_id_include(section_id, "Data") and section_id_include(section_id, "No confirm")
      men = section_id_men(section_id)
      women = section_id_women(section_id)
      if men != nil and women != nil and (men.to_f + women.to_f) > 0
        men = men.to_f
        women = women.to_f
        return ((men - women) / (men + women)) * 100
      end
    end
    false
  end


  # returns a flag representing the gap aritmetic operation
  # also compares the gab with the max gab value for each section
  def section_gab_flag(section)
    brecha = section_gab(section)

    if brecha == false
      0
    elsif brecha.to_f < 0
      -1
    elsif brecha.to_f < section.gap_max.to_f
      1
    else
      2
    end
  end

  # returns a message based in the gab flag value
  def section_gab_message(section)
    brecha = section_gab_flag(section)

    case brecha
    when false
      'No brindaste una respuesta a esta pregunta'
    when -1
      section.recommendation_negative.html_safe
    when 1
      section.recommendation.html_safe
    else
      section.recommendation_gap_max.html_safe
    end
  end

  # returns a gab point if the gab is in a good range
  def section_gab_point(section)
    case section_gab_flag(section)
    when false
    when -1
      0
    when 1
      1
    else
      0
    end
  end

  def barchart_gab_avg_real(porc_avg, porc_gab)
    [
      ['BRECHA PROMEDIO (%)', porc_avg],
      ['BRECHA OBTENIDA (%)', porc_gab]
    ]
  end

  def piechart_men_women_data(men, women)
    [
      ['Hombres', men],
      ['Mujeres', women]
    ]
  end

  def piechart_men_women_data_by_answer(answer)
    case answer.to_i
    when 1
      piechart_men_women_data(0,100)
    when 2
      piechart_men_women_data(25,75)
    when 3
      piechart_men_women_data(50,50)
    when 4
      piechart_men_women_data(75,25)
    when 5
      piechart_men_women_data(100,0)
    else
      []
    end
  end

  def piechart_description(answer)
    cases = {
      '1' => 'Actividad exclusiva para mujeres',
      '2' => 'Actividad donde participan más las mujeres que los hombres',
      '3' => 'Actividad donde la participación de hombres y mujeres es equitativa (50/50)',
      '4' => 'Actividad donde participan más los hombres que las mujeres',
      '5' => 'Actividad exclusiva para hombres',
    }

    cases[answer.to_s] || ''
  end

  def checkbox_image_by_question_id(question_id)
    cases = {
      "127" => "/images/igualdad2.png",
      "128" => "/images/politico.png",
      "129" => "/images/mujer.png",
      "130" => "/images/dinero.png",
      "131" => "/images/garantia.png",
    }

    cases[question_id.to_s] || ''
  end

  def checkbox_title_yes_by_question_id(question_id)
    cases = {
      '127' => 'La organización si cuenta con una estrategia y política de género',
      '128' => "La organización si esta implementando la política bajo una estrategia de género",
      '129' => "La organización si cuenta con políticas de crédito diferenciadas para mujeres",
      '130' => "La organización si brinda financiamiento",
      '131' => "La organización si usa lenguaje inclusivo y sin discriminación en: Estatutos, Reglamentos, Políticas, Actas, Sistemas de Control Interno, Sistemas de Gestion Interna",
    }

    cases[question_id.to_s] || ''
  end

  def checkbox_title_no_by_question_id(question_id)
    cases = {
      '127' => 'La organización no cuenta con una estrategia y política de género',
      '128' => "La organización no esta implementando la política bajo una estrategia de género",
      '129' => "La organización no cuenta con políticas de crédito diferenciadas para mujeres",
      '130' => "La organización no brinda financiamiento",
      '131' => "La organización no usa lenguaje inclusivo y sin discriminación en: Estatutos, Reglamentos, Políticas, Actas, Sistemas de Control Interno, Sistemas de Gestion Interna",
    }

    cases[question_id.to_s] || ''
  end

end